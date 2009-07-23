From: Haneef Syed <Haneef.Syed@lntinfotech.com>
Subject: Re: KVM-88 Crash with Linux-2.6.25 kernel
Date: Thu, 23 Jul 2009 15:13:25 +0530
Message-ID: <OF8F9E5470.1659BFDC-ON652575FC.0035444E-652575FC.00356A3B__41562.5923350037$1248373873$gmane$org@lntinfotech.com>
References: <20090723093933.GD7928@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090723093933.GD7928@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If i use kvm-88 kernel package then system does not crash

but it uses qemu emulation but not kvm. I want kvm emulation so

can u tell me how to achieve that.




Gleb Natapov <gleb@redhat.com> 
07/23/2009 03:09 PM

To
Haneef Syed <Haneef.Syed@lntinfotech.com>
cc
kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
avi@redhat.com
Subject
Re: KVM-88 Crash with Linux-2.6.25 kernel






On Thu, Jul 23, 2009 at 03:06:07PM +0530, Haneef Syed wrote:
> Hi All,
> 
> I am using kvm-88 user space package with linux-2.6.25 kernel. I f i run 

> following command system gets hang.
> 
Please use kvm-88 kernel package.

> ./qemu-system-x86_64 -hda new.qcow2 -cdrom rhel-server-5.3-i386-dvd.iso 
> -boot d -m 512
> 
> When i print dmesg it displays as follows:
> 
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 

> 00000024
>  printing eip:
> c0425fb0
> *pde = 3963c067
> Oops: 0000 [#1]
> SMP
> Modules linked in: ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 
> xt_state nf_conntrack nfnetlink ipt_REJECT xt_tcpudp iptable_filter 
> ip_tables x_tables bridge rfcomm l2cap bluetooth autofs4 sunrpc ib_iser 
> rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi 
> scsi_transport_iscsi cpufreq_ondemand acpi_cpufreq loop dm_multipath 
ipv6 
> kvm_intel kvm snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss 
> snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss 
> snd_pcm snd_timer snd soundcore via_rhine i2c_i801 parport_pc 
> snd_page_alloc mii parport i2c_core serio_raw pcspkr sg ata_generic 
> dm_snapshot dm_zero dm_mirror dm_mod ahci libata sd_mod scsi_mod ext3 
jbd 
> mbcache uhci_hcd ohci_hcd ehci_hcd
> CPU:    0
> EIP:    0060:[<c0425fb0>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.21.kvm-25-21 #14)
> EIP is at do_exit+0x2ca/0x3c8
> eax: 00000000   ebx: f7c51dc0   ecx: 00000001   edx: f7bc80f0
> esi: f7bc80f0   edi: 00000000   ebp: 00000100   esp: f5372f84
> ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
> Process qemu-system-x86 (pid: 3668[#0], ti=f5372000 task=f7bc80f0 
> task.ti=f5372000)
> Stack: f7bc80f0 00000100 f5372000 c042cdf8 f7bb1580 f7a15ac0 00000100 
> f5372000
>        c0426144 00000001 00d55274 00d55274 c0404db0 00000001 b77956d0 
> 00000000
>        00d55274 00d55274 b7795738 000000fc ffff007b c040007b c0600000 
> 000000fc
> Call Trace:
>  [<c042cdf8>] signal_wake_up+0x1e/0x2c
>  [<c0426144>] sys_exit_group+0x0/0xd
>  [<c0404db0>] syscall_call+0x7/0xb
>  [<c0600000>] packet_setsockopt+0x13f/0x170
>  =======================
> Code: ab 04 00 e8 f7 d4 fd ff 85 ff 74 19 8b 86 6c 04 00 00 83 b8 b0 00 
00 
> 00 00 74 0a b8 01 00 00 00 e8 7e 64 10 00 8b 46 04 8b 40 04 <8b> 40 24 
e8 
> 94 0d 02 00 8b 86 a4 00 00 00 85 c0 74 08 8b 40 04
> EIP: [<c0425fb0>] do_exit+0x2ca/0x3c8 SS:ESP 0068:f5372f84
> Fixing recursive fault but reboot is needed!
> 
> Please suggest me how to fix this bug..
> 
> Thanks in advance :-))
> 
> 
> ______________________________________________________________________
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
                                                 Gleb.

______________________________________________________________________



______________________________________________________________________
