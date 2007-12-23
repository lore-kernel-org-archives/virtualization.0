From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [Virtio-for-kvm] [PATCH 7/7] userspace virtio
Date: Sun, 23 Dec 2007 12:56:45 +0200
Message-ID: <476E3EED.8070005__20650.8489362479$1198407489$gmane$org@qumranet.com>
References: <476BD1A9.2040701@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <476BD1A9.2040701@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
>  From f244bcad756c4f761627557bb7f315b1d8f22fb2 Mon Sep 17 00:00:00 2001
> From: Dor Laor <dor.laor@qumranet.com>
> Date: Thu, 20 Dec 2007 13:26:30 +0200
> Subject: [PATCH] [VIRTIO-NET] Rx performance improvement
>  The current performance are not good enough, the problem lies
>  in qemu tap handling code that caused to pass packets one at
>  a time and also to copy them to a temporal buffer.
>
> This patch prevents qemu handlers from reading the tap and instead
> it selects the tap descriptors for virtio devices.
> This eliminates copies and also batch guest notifications (interrupts).
>
> Using this patch the rx performance reaches 800Mbps.
> The patch does not follow qemu's api since the intention is first to have
> a better io in kvm and then to polish it correctly.
>
>   

This breaks -net user, which is one of the motivations for having a qemu 
net device.  We need to maintain the old path for that, and only use the 
new fast path if using -net tap.


-- 
error compiling committee.c: too many arguments to function
