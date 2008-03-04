From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: Re: [kvm-devel] I/O bandwidth control on KVM
Date: Tue, 04 Mar 2008 15:41:09 +0900 (JST)
Message-ID: <20080304.154109.193687573.ryov__3240.80852228708$1204612991$gmane$org@valinux.co.jp>
References: <20080229.210531.226799765.ryov__28298.7898834564$1204287044$gmane$org@valinux.co.jp>
	<47CA2A7B.8000400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CA2A7B.8000400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: anthony@codemonkey.ws
Cc: kvm-devel@lists.sourceforge.net, dm-devel@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

> If you are using virtio drivers in the guest (which I presume you are given the reference to /dev/vda), try using the following -drive syntax:
>
> -drive file=/dev/mapper/ioband1,if=virtio,boot=on,cache=off
>
> This will force the use of O_DIRECT.  By default, QEMU does not open with O_DIRECT so you'll see page cache effects.

Thank you for your suggestion.
I was using virtio drives as you wrote.
I just thought that kvm would use O_DIRECT option when applications on
the guest opened files with O_DIRECT option.
I'll try the way you mentioned and report back.

Thanks,
Ryo Tsuruta
