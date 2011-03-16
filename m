From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/02] virtio: Virtio platform driver
Date: Wed, 16 Mar 2011 14:17:15 +0900
Message-ID: <AANLkTi=zjGubKx0vV+hqEYiVFVNTAEoGwxEfL4oprxk8__39025.9741958745$1300252676$gmane$org@mail.gmail.com>
References: <20110310070541.27327.52089.sendpatchset@t400s>
	<87d3lriv7e.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d3lriv7e.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

On Wed, Mar 16, 2011 at 12:46 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> On Thu, 10 Mar 2011 16:05:41 +0900, Magnus Damm <magnus.damm@gmail.com> wrote:
>> virtio: Virtio platform driver
>>
>> [PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
>> [PATCH 02/02] virtio: Add virtio platform driver
>
> I have no problem with these patches, but it's just churn until we see
> your actual drivers.

Well, actually this platform driver is used together with already
existing drivers, so there are no new virtio drivers to wait for.

The drivers that have been tested are so far:

CONFIG_VIRTIO_CONSOLE=y
CONFIG_VIRTIO_NET=y

At this point there are four different pieces of code working together

1) Virtio platform driver patches (for guest)
2) SH4AL-DSP guest kernel patch
3) ARM UIO driver patches (for host)
4) User space backing code for ARM based on lguest.c

These patches in this mail thread are 1), and I decided to brush up
that portion and submit upstream because it's the part that is easiest
to break out. I intend to post the rest bit by bit over time, but if
someone is interested then I can post everything at once too.

> The S/390 devs might be interested, as their bus is very similar too...

The lguest device code is very similar as well, perhaps it's worth
refactoring that a bit to build on top of the platform driver. Not
sure if you see that as a move in the right direction though.

Thanks for your feedback!

/ magnus
