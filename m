From: "Thomas D." <whissi@whissi.de>
Subject: Re: req->nr_phys_segments > queue_max_segments (was Re: kernel BUG at
	drivers/block/virtio_blk.c:172!)
Date: Thu, 1 Oct 2015 15:36:28 +0200
Message-ID: <560D36DC.5050205__38310.4878398173$1443710289$gmane$org@whissi.de>
References: <560C87F6.4080708@whissi.de>
	<20151001114817-mutt-send-email-mst@redhat.com>
	<560CFAD3.1030607@suse.de>
	<CAMM=eLcyT2JeWn4NJ6gjsHcRz_D8YcixLix64Spg9cVYFexGyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMM=eLcyT2JeWn4NJ6gjsHcRz_D8YcixLix64Spg9cVYFexGyA@mail.gmail.com>
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

Hi,

Mike Snitzer wrote:
> This particular dm-crypt on virtio-blk issue is fixed with this commit:
> http://git.kernel.org/linus/586b286b110e94eb31840ac5afc0c24e0881fe34
> 
> Linus pulled this into v4.3-rc3.

I have this patch applied to linux-4.1.9. This could be the reason why I
don't see the issue on boot with linux-4.1.9.

So is the freeze I am experiencing with linux-4.1.9 another issue
introduced with linux-4.1.9 or another symptom/regression? Any idea?


-Thomas
