From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: virtio_blk: Rename a jump label in virtblk_get_id()
Date: Mon, 3 Oct 2016 14:12:39 +0200
Message-ID: <051e7718-b5bb-e716-b2c0-515ee4488c4a__20640.615389175$1475496796$gmane$org@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<a303f7a6-c675-5228-99bd-a03c9e9252e9@users.sourceforge.net>
	<CAJSP0QV2WUJPqeiSKcWiXWk+AoJ2MGo2zG4=JQ2tfpTprAyV=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QV2WUJPqeiSKcWiXWk+AoJ2MGo2zG4=JQ2tfpTprAyV=g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

>> Adjust a jump label according to the current Linux coding style convention.
> 
> I think you mean "goto label".  "Jump label" has a different meaning,
> see <linux/jump_label.h>.

Does a "goto" statement jump to the code position finally
which is specified by the label?


>> @@ -247,10 +247,10 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>>
>>         err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>>         if (err)
>> -               goto out;
>> +               goto put_request;
>>
>>         err = blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
>> -out:
>> + put_request:
> 
> I checked Documentation/CodingStyle and see no reason to rename the label.

Can the suggested longer identifier explain better the "what" and "why"
for this software situation?


> It's also not clear why you added a space.  The CodingStyle example
> does not use a space before the label.

Do you find information from a commit like "docs: Remove space-before-label guidance
from CodingStyle" (from 2016-09-21) interesting?   ;-)
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/Documentation/CodingStyle?id=79c70c304b0b443429b2a0019518532c5162817a

Regards,
Markus
