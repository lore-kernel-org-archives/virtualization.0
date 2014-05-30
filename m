From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: virtio_blk: don't hold spin lock during world
	switch
Date: Fri, 30 May 2014 07:52:08 -0600
Message-ID: <53888D08.1050602@kernel.dk>
References: <1401418169-3361-1-git-send-email-ming.lei@canonical.com>
	<5387F8B2.1070509@kernel.dk>
	<CACVXFVPoG6_fL_MTRF+616W7UdHpSgjtMLBLeBn4OGR63haw3w@mail.gmail.com>
	<5387FC96.4030508@kernel.dk> <877g537q6d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <877g537q6d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Ming Lei <ming.lei@canonical.com>
Cc: virtualization@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2014-05-30 00:10, Rusty Russell wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> If Rusty agrees, I'd like to add it for 3.16 with a stable marker.
>
> Really stable?  It improves performance, which is nice.  But every patch
> which goes into the kernel fixes a bug, improves clarity, improves
> performance or adds a feature.  I've now seen all four cases get CC'd
> into stable.
>
> Including some of mine explicitly not marked stable which get swept up
> by enthusiastic stable maintainers :(
>
> Is now there *any* patch short of a major rewrite which shouldn't get
> cc: stable?

I agree that there's sometimes an unfortunate trend there. I didn't 
check, but my assumption was that this is a regression after the blk-mq 
conversion, in which case I do think it belongs in stable.

But in any case, I think the patch is obviously correct and the wins are 
sufficiently large to warrant a stable inclusion even if it isn't a 
regression.

-- 
Jens Axboe
