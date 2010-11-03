From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Wed, 03 Nov 2010 17:49:22 +0000
Message-ID: <4CD1A0A2.5080507@collabora.co.uk>
References: <4CAC9CD1.2050601@collabora.co.uk>	<4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk>	<4CBD7560.6080207@redhat.com>	<4CC8226F.5080807@collabora.co.uk>	<4CC94203.1080207@redhat.com>	<4CC9647A.50108@collabora.co.uk>	<4CC98784.7020907@redhat.com>	<4CC9D472.2080109@collabora.co.uk>	<4CCE9989.2010809@redhat.com> <4CCEBEE2.8010404@codemonkey.ws>	<4CCEE172.2010600@collabora.co.uk> <4CCEE374.4050805@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CCEE374.4050805@codemonkey.ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: QEMU Developers <qemu-devel@nongnu.org>, virtualization@lists.osdl.org, Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/10 15:57, Anthony Liguori wrote:

>> It very much is. It supports fully visually integrated rendering (no
>> overlay windows) and even compositing GL window managers work fine,
>> even if running 3D apps under them.
>
> Does the kernel track userspace pid and pass that information to qemu?

Yes. And the qemu code tracks the PIDs and keeps multiple queues (one 
per pid).

-Ian
