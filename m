From: "Thomas D." <whissi@whissi.de>
Subject: Re: req->nr_phys_segments > queue_max_segments (was Re: kernel BUG at
	drivers/block/virtio_blk.c:172!)
Date: Thu, 1 Oct 2015 18:06:19 +0200
Message-ID: <560D59FB.7020501__28887.4364494861$1443715600$gmane$org@whissi.de>
References: <560C87F6.4080708@whissi.de>
	<20151001114817-mutt-send-email-mst@redhat.com>
	<560CFAD3.1030607@suse.de>
	<CAMM=eLcyT2JeWn4NJ6gjsHcRz_D8YcixLix64Spg9cVYFexGyA@mail.gmail.com>
	<560D36DC.5050205@whissi.de> <560D52DE.3020303@whissi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <560D52DE.3020303@whissi.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mike Snitzer <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>, "linux-scsi@vger.kernel.org" <Linux-scsi@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi

> seems like we have two problems:
> 
> The first (origin) problem seems to be already fixed by Mike's patch.
> 
> I applied the patch against linux-4.1.8, rebooted several times without
> a problem. But I'll keep testing for sure.

I already experienced one freeze with linux-4.1.8 and Mike's patch (same
like in 4.1.9). Doesn't mean that this is related to Mike's patch (I see
the same freezes with vanilla 4.1.9 not containing the patch with a
higher frequency).


-Thomas
