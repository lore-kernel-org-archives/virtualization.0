From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V5 0/4] Improve virtio-blk performance
Date: Thu, 02 Aug 2012 23:40:51 +0200
Message-ID: <501AF3E3.6090403@kernel.dk>
References: <1343888757-25723-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343888757-25723-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 08/02/2012 08:25 AM, Asias He wrote:
> Hi folks,
> 
> This version added REQ_FLUSH and REQ_FUA support as suggested by Christoph and
> rebased against latest linus's tree. 
> 
> Jens, could you please consider picking up the dependencies 1/4 and
> 2/4 in your tree. Thanks!

Pickedup, thanks for getting that done!


-- 
Jens Axboe
