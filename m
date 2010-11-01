From: Ian Molton <ian.molton@collabora.co.uk>
Subject: Re: [Qemu-devel] Re: [PATCH] Implement a virtio GPU transport
Date: Mon, 01 Nov 2010 15:50:18 +0000
Message-ID: <4CCEE1BA.5030404@collabora.co.uk>
References: <4CAC9CD1.2050601@collabora.co.uk>	<4CB1D79A.6070805@redhat.com>	<4CBD739A.2010500@collabora.co.uk>	<4CBD7560.6080207@redhat.com> <4CC8226F.5080807@collabora.co.uk>	<4CC94203.1080207@redhat.com> <4CC9647A.50108@collabora.co.uk> <4CC98784.7020907@redhat.com> <4CC9D472.2080109@collabora.co.uk> <4CCE9989.2010809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CCE9989.2010809@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/11/10 10:42, Avi Kivity wrote:
>> No, not really. the guest may call for the scene to be rendered at
>> any time and we have to wait for that to happen before we can
>> return the data to it.
>
> Waiting for a response is fine, but can't the guest issue a second
> batch while waiting for the first?

No. Userspace doesnt do or expect that.

Multiple applications work fine, however.

-Ian
