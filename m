From: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 3/4] io controller: Core IO controller implementationlogic
Date: Sat, 8 Nov 2008 11:35:48 +0900 (JST)
Message-ID: <36332.10.75.179.62.1226111748.squirrel__2678.99440737001$1226111904$gmane$org@webmail-b.css.fujitsu.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.869625751@redhat.com>
	<20081107122145.69500cd3.kamezawa.hiroyu@jp.fujitsu.com>
	<20081107145036.GF21884@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107145036.GF21884@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Vivek Goyal said:
> On Fri, Nov 07, 2008 at 12:21:45PM +0900, KAMEZAWA Hiroyuki wrote:
>> On Thu, 06 Nov 2008 10:30:25 -0500
>> vgoyal@redhat.com wrote:
>>
>> >
>> > o Core IO controller implementation
>> >
>> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>> >
>>
>> 2 comments after a quick look.
>>
>>  - I don't recommend generic work queue. More stacked dependency between
>> "work"
>>    is not good. (I think disk-driver uses "work" for their jobs.)
>
> Sorry, I did not get this. Are you recommending that don't create a new
> work queue, instead use existing work queue (say kblockd) to submit the
> bios
> here?
>
Ah, no, recomending new-original its own workqueue. I'm sorry that it seems
I missed something at reading your patch.
(other person may have other opinion, here;)

> I will look into it. I was little worried about a kblockd being overworked
> in case of too many logical devices enabling IO controller.
>

Thanks,
-Kame
