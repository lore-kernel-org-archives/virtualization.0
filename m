From: Tyler Slabinski <tslabinski@slabity.net>
Subject: PROBLEM: VirtIO DRM driver crashes when setting specific 16.16
	fixed-point property values
Date: Fri, 24 May 2019 14:46:50 -0400
Message-ID: <CAOoxD-tWknshQLXFzyv2t1CVhfK0SCNec=6MVij9q6kQAVzY=g__1256.49960698269$1563994809$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VirtIO DRM driver crashes when setting specific 16.16 fixed-point
property values

When running a virtual machine with a VirtIO GPU, it's possible to
crash the entire VM by setting the value of a 16.16 fixed-point
property to any value below 65536 (1.0 in 16.16 format or 0x00010000).
As a specific example, setting the SRC_W property on a plane DRM
object to a value of 30000 will cause the VM to hard-shutdown.

Keywords; DRM, GPU, Virtualization, KMS, Kernel, VirtIO, Virtualization

Kernel information:
Linux version 4.19.44 (nixbld@localhost) (gcc version 7.4.0 (GCC))
#1-NixOS SMP Thu May 16 17:41:32 UTC 2019

Log output: No related errors in the logs.

To reproduce: Create a VM with a VirtIO GPU and set the property as
described above.

I have a personal project that lets you execute specific DRM commands
one at a time: https://github.com/Smithay/drm-rs/blob/develop/examples/kms_interactive.rs

Here's a snippet of what happens:

```
$ sudo cargo run --example kms_interactive
...
KMS>> GetResources        # List out DRM resource
    Connectors: [connector::Handle(31)]
    Encoders: [encoder::Handle(32)]
    CRTCS: [crtc::Handle(30)]
    Framebuffers: [...]
    Planes: [plane::Handle(28), plane::Handle(29)]
KMS>> GetProperties 28        # Get properties of plane with handle 28
    Property: property::Handle(7)    Value: 1
    Property: property::Handle(16)    Value: 69
    ...
    Property: property::Handle(10)    Value: 67108864
    Property: property::Handle(11)    Value: 50331648
KMS>> GetInfo 10        # Get info of property 10
    Name: "SRC_W"
    Mutable: true
    Atomic: false
    Value: UnsignedRange(0, 4294967295)
KMS>> SetProperty 28 10 65536        # Set the value of property 10 on
plane 28 to value 65536 (succeeds)
KMS>> SetProperty 28 10 60000        # Set the value of property 10 on
plane 28 to value 60000
```

At this point the VM has shut down.

Environment:
Linux nixos 4.19.44 #1-NixOS SMP Thu May 16 17:41:32 UTC 2019 x86_64 GNU/Linux

GNU C               7.4.0
Binutils             2.31.1
Util-linux           2.33.2
Mount               2.33.2
Module-init-tools   26
E2fsprogs           1.45.0
Linux C Library     2.27
Dynamic linker (ldd) 2.27
Procps               3.3.15
Net-tools           1.60
Kbd                 2.0.4
Console-tools       2.0.4
Sh-utils             8.31
Udev                 239
Modules Loaded       8021q aesni_intel aes_x86_64 af_packet agpgart
ahci atkbd autofs4 btrfs button cfg80211 crc32c_generic crc32c_intel
crc32_pclmul crc_ccitt crct10dif_pclmul cryptd crypto_simd deflate
dm_mod drm drm_kms_helper efi_pstore efivarfs efivars ehci_hcd
ehci_pci evdev failover fat fb_sys_fops ghash_clmulni_intel
glue_helper hid hid_generic i2c_core i2c_i801 i8042 input_leds
intel_agp intel_gtt ip6table_filter ip6table_raw ip6_tables
ip6t_rpfilter iptable_filter iptable_nat iptable_raw ip_tables
ipt_rpfilter ipv6 irqbypass iTCO_wdt joydev kvm led_class libahci
libata libcrc32c libps2 loop lpc_ich mac_hid mousedev net_failover
nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 nf_log_common nf_log_ipv4
nf_log_ipv6 nf_nat nf_nat_ipv4 nls_cp437 nls_iso8859_1 pcbc psmouse
pstore qemu_fw_cfg raid6_pq rfkill rng_core rtc_cmos scsi_mod serio
serio_raw snd snd_hda_codec snd_hda_codec_generic snd_hda_core
snd_hda_intel snd_hwdep snd_pcm snd_timer soundcore syscopyarea
sysfillrect sysimgblt ttm uhci_hcd usb_common usbcore usbhid vfat
virtio virtio_balloon virtio_blk virtio_console virtio_gpu virtio_net
virtio_pci virtio_ring virtio_rng xor x_tables xt_conntrack xt_LOG
xt_pkttype xt_tcpudp xxhash zstd_compress zstd_decompress

XML Configuration for VM:
```
<domain type='kvm' id='11'>
  <name>DRM-test</name>
  <uuid>07c20472-206a-4367-8a9c-11b39b836896</uuid>
  <memory unit='KiB'>4194304</memory>
  <currentMemory unit='KiB'>4194304</currentMemory>
  <vcpu placement='static'>2</vcpu>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch='x86_64' machine='pc-q35-3.1'>hvm</type>
    <loader readonly='yes'
type='pflash'>/run/libvirt/nix-ovmf/OVMF_CODE.fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/DRM-test_VARS.fd</nvram>
  </os>
  <features>
    <acpi/>
    <apic/>
    <vmport state='off'/>
  </features>
  <cpu mode='custom' match='exact' check='full'>
    <model fallback='forbid'>Skylake-Client-IBRS</model>
    <vendor>Intel</vendor>
    <feature policy='require' name='ss'/>
    <feature policy='require' name='vmx'/>
    <feature policy='require' name='hypervisor'/>
    <feature policy='require' name='tsc_adjust'/>
    <feature policy='require' name='clflushopt'/>
    <feature policy='require' name='umip'/>
    <feature policy='require' name='ssbd'/>
    <feature policy='require' name='xsaves'/>
    <feature policy='require' name='pdpe1gb'/>
    <feature policy='disable' name='hle'/>
    <feature policy='disable' name='rtm'/>
  </cpu>
  <clock offset='utc'>
    <timer name='rtc' tickpolicy='catchup'/>
    <timer name='pit' tickpolicy='delay'/>
    <timer name='hpet' present='no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>
  <devices>
    <emulator>/run/libvirt/nix-emulators/qemu-system-x86_64</emulator>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/var/lib/libvirt/images/DRM-test.qcow2'/>
      <backingStore/>
      <target dev='vda' bus='virtio'/>
      <boot order='2'/>
      <alias name='virtio-disk0'/>
      <address type='pci' domain='0x0000' bus='0x04' slot='0x00'
function='0x0'/>
    </disk>
    <controller type='usb' index='0' model='ich9-ehci1'>
      <alias name='usb'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
function='0x7'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci1'>
      <alias name='usb'/>
      <master startport='0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
function='0x0' multifunction='on'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci2'>
      <alias name='usb'/>
      <master startport='2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
function='0x1'/>
    </controller>
    <controller type='usb' index='0' model='ich9-uhci3'>
      <alias name='usb'/>
      <master startport='4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
function='0x2'/>
    </controller>
    <controller type='sata' index='0'>
      <alias name='ide'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x1f'
function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pcie-root'>
      <alias name='pcie.0'/>
    </controller>
    <controller type='pci' index='1' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='1' port='0x10'/>
      <alias name='pci.1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x0' multifunction='on'/>
    </controller>
    <controller type='pci' index='2' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='2' port='0x11'/>
      <alias name='pci.2'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x1'/>
    </controller>
    <controller type='pci' index='3' model='pcie-to-pci-bridge'>
      <model name='pcie-pci-bridge'/>
      <alias name='pci.3'/>
      <address type='pci' domain='0x0000' bus='0x01' slot='0x00'
function='0x0'/>
    </controller>
    <controller type='pci' index='4' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='4' port='0x12'/>
      <alias name='pci.4'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x2'/>
    </controller>
    <controller type='pci' index='5' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='5' port='0x13'/>
      <alias name='pci.5'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x3'/>
    </controller>
    <controller type='pci' index='6' model='pcie-root-port'>
      <model name='pcie-root-port'/>
      <target chassis='6' port='0x14'/>
      <alias name='pci.6'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x4'/>
    </controller>
    <interface type='network'>
      <mac address='52:54:00:60:c1:ab'/>
      <source network='default' bridge='virbr0'/>
      <target dev='vnet0'/>
      <model type='virtio'/>
      <alias name='net0'/>
      <address type='pci' domain='0x0000' bus='0x02' slot='0x00'
function='0x0'/>
    </interface>
    <serial type='pty'>
      <source path='/dev/pts/2'/>
      <target type='isa-serial' port='0'>
        <model name='isa-serial'/>
      </target>
      <alias name='serial0'/>
    </serial>
    <console type='pty' tty='/dev/pts/2'>
      <source path='/dev/pts/2'/>
      <target type='serial' port='0'/>
      <alias name='serial0'/>
    </console>
    <input type='tablet' bus='usb'>
      <alias name='input0'/>
      <address type='usb' bus='0' port='1'/>
    </input>
    <input type='mouse' bus='ps2'>
      <alias name='input1'/>
    </input>
    <input type='keyboard' bus='ps2'>
      <alias name='input2'/>
    </input>
    <graphics type='spice' port='5900' autoport='yes' listen='127.0.0.1'>
      <listen type='address' address='127.0.0.1'/>
      <image compression='off'/>
    </graphics>
    <sound model='ich6'>
      <alias name='sound0'/>
      <address type='pci' domain='0x0000' bus='0x03' slot='0x01'
function='0x0'/>
    </sound>
    <video>
      <model type='virtio' heads='1' primary='yes'/>
      <alias name='video0'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x0'/>
    </video>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir0'/>
      <address type='usb' bus='0' port='2'/>
    </redirdev>
    <redirdev bus='usb' type='spicevmc'>
      <alias name='redir1'/>
      <address type='usb' bus='0' port='3'/>
    </redirdev>
    <memballoon model='virtio'>
      <alias name='balloon0'/>
      <address type='pci' domain='0x0000' bus='0x05' slot='0x00'
function='0x0'/>
    </memballoon>
  </devices>
  <seclabel type='dynamic' model='dac' relabel='yes'>
    <label>+0:+0</label>
    <imagelabel>+0:+0</imagelabel>
  </seclabel>
</domain>
```
