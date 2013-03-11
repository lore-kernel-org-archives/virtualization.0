From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] block: replace kmalloc and then memcpy with kmemdup
Date: Mon, 11 Mar 2013 17:17:02 +0200
Message-ID: <CAEnQRZBZr+7tLxmSL44q8avpDX7x2yG36ruQAv+9diudhQF_kQ@mail.gmail.com>
References: <1363001016-8439-1-git-send-email-mihneadb@gmail.com>
	<20130311145435.GB26394@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130311145435.GB26394@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Mihnea Dobrescu-Balaur <mihneadb@gmail.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Konrad,

The performance is the same using kmemdup, but we have the following advantages:
* code is cleaner
* kmemdup adds additional debugging info useful for tracking the real
place where memory was allocated [1] [2].

thanks,
Daniel.

[1] http://lxr.linux.no/#linux+v3.8.2/mm/util.c#L61
[2] http://lxr.linux.no/#linux+v3.8.2/include/linux/slab.h#L363

On Mon, Mar 11, 2013 at 4:54 PM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> On Mon, Mar 11, 2013 at 01:23:36PM +0200, Mihnea Dobrescu-Balaur wrote:
>
> Are there performance improvements to doing it this way?
>
>> Signed-off-by: Mihnea Dobrescu-Balaur <mihneadb@gmail.com>
>> ---
>>  drivers/block/xen-blkfront.c |    3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index c3dae2e..9620644 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -1203,11 +1203,10 @@ static int blkif_recover(struct blkfront_info *info)
>>       int j;
>>
>>       /* Stage 1: Make a safe copy of the shadow state. */
>> -     copy = kmalloc(sizeof(info->shadow),
>> +     copy = kmemdup(info->shadow, sizeof(info->shadow),
>>                      GFP_NOIO | __GFP_REPEAT | __GFP_HIGH);
>>       if (!copy)
>>               return -ENOMEM;
>> -     memcpy(copy, info->shadow, sizeof(info->shadow));
>>
>>       /* Stage 2: Set up free list. */
>>       memset(&info->shadow, 0, sizeof(info->shadow));
>> --
>> 1.7.10.4
>>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
