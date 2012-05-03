From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 1/2] virtio-blk: Fix hot-unplug race in remove method
Date: Thu, 03 May 2012 15:36:56 +0800
Message-ID: <4FA23598.5040701@redhat.com>
References: <1336011592-24889-1-git-send-email-asias@redhat.com>
	<CA+1xoqcKQmSQxvUR6syvseUow4AfcnKmDODW=j6t6gejmSi4NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+1xoqcKQmSQxvUR6syvseUow4AfcnKmDODW=j6t6gejmSi4NA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/03/2012 01:02 PM, Sasha Levin wrote:
> On Thu, May 3, 2012 at 4:19 AM, Asias He<asias@redhat.com>  wrote:
>> @@ -190,6 +194,7 @@ static void do_virtblk_request(struct request_queue *q)
>>
>>         while ((req = blk_peek_request(q)) != NULL) {
>>                 BUG_ON(req->nr_phys_segments + 2>  vblk->sg_elems);
>> +               vblk->req_in_flight++;
>>
>>                 /* If this request fails, stop queue and wait for something to
>>                    finish to restart it. */
>
> This is being increased before we know if the request will actually be
> sent, so if do_req() fails afterwards, req_in_flight would be
> increased but the request will never be sent.
>
> Which means we won't be able to unplug the device ever.

Yes, you are right. This introduces another race. I could do 
vblk->req_in_flight++ right after blk_start_request(req) to avoid this 
race.

> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Asias
