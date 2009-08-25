From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Tue, 25 Aug 2009 16:34:45 +0300
Message-ID: <20090825133445.GB13949__25506.7730359317$1251207723$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com>
	<20090824212137.GA9835@redhat.com>
	<4A934AF7.2090904@codemonkey.ws> <4A936525.5030300@redhat.com>
	<20090825064604.GB10429@redhat.com>
	<4A93E235.5040008@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A93E235.5040008@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Mark McLoughlin <markmc@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 08:08:05AM -0500, Anthony Liguori wrote:
> Michael S. Tsirkin wrote:
>>> My preference is ring proxying.  Not we'll need ring proxying (or at  
>>> least event proxying) for non-MSI guests.
>>>     
>>
>> Exactly, that's what I meant earlier. That's enough, isn't it, Anthony?
>>   
>
> It is if we have a working implementation that demonstrates the
> userspace interface is sufficient.

The idea is trivial enough to be sure the interface is sufficient:
we point kernel at used buffer at address X, and
copy stuff from there to guest buffer, then signal guest.
I'll post a code snippet to show how it's done if you like.

> Once it goes into the upstream
> kernel, we need to have backwards compatibility code in QEMU forever
> to  support that kernel version.

Don't worry: kernel needs to handle old userspace as well, and neither I
nor Rusty want to have a compatibility mess in kernel.

> Regards,
>
> Anthony Liguori
