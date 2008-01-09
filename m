From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Wed,  9 Jan 2008 08:21:04 -0200
Message-ID: <11998740663306-git-send-email-gcosta__44564.4242143773$1199874229$gmane$org@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: virtualization@lists.linux-foundation.org, marcelot@redhat.com, anthony@codemonkey.ws
List-Id: virtualization@lists.linuxfoundation.org

I'm sending a first draft of my proposed cpu hotplug driver for kvm/virtio
The first patch is the kernel module, while the second, the userspace pci device.

The host boots with the maximum cpus it should ever use, through the -smp parameter.
Due to real machine constraints (which qemu copies), i386 does not allow for any addition
of cpus after boot, so this is the most general way.

I do however, include an "attempt_buffer" in the userspace part. It's purpose is to
allow tools like virt-manager to set a max_cpus (-smp), and a desired number of cpus
in their configuration files. (and AFAICT, there's is no easy way for them to tell when the
backend driver is up and running)

Other than that, it should be pretty much straightforward.

Looking forward for your comments
