From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: pci: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 18 Sep 2014 14:53:10 +0930
Message-ID: <87oaudo62p.fsf@rustcorp.com.au>
References: <003a01cfc8bc$bf48cd60$3dda6820$%han@samsung.com>
	<8761gxk5vt.fsf@rustcorp.com.au>
	<000d01cfd25d$0add23d0$20976b70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000d01cfd25d$0add23d0$20976b70$%han@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: 'Jingoo Han' <jg1.han@samsung.com>, virtualization@lists.linux-foundation.org, "'Michael S. Tsirkin'" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jingoo Han <jg1.han@samsung.com> writes:
> On Tuesday, September 09, 2014 9:14 AM, Rusty Russell wrote:
>> Jingoo Han <jg1.han@samsung.com> writes:
>> > Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
>> >
>> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>> 
>> This patch is obviously wrong.  It won't compile without
>> CONFIG_PM_SLEEP.
>
> No, there is no compile issue.
> When, CONFIG_PM_SLEEP=n, there is no build error.

My mistake.  Thanks, I've applied it.  It probably won't go in until the
next merge window, however, since I'm travelling for this one.

Cheers,
Rusty.
