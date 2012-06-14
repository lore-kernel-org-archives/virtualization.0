From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC 1/2] block: Add blk_bio_map_sg() helper
Date: Thu, 14 Jun 2012 11:31:56 +0900
Message-ID: <20120614023156.GB3766@dhcp-172-17-108-109.mtv.corp.google.com>
References: <1339573307-11537-1-git-send-email-asias@redhat.com>
	<1339573307-11537-2-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1339573307-11537-2-git-send-email-asias@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 13, 2012 at 03:41:46PM +0800, Asias He wrote:
> Add a helper to map a bio to a scatterlist, modelled after
> blk_rq_map_sg.
> 
> This helper is useful for any driver that wants to create
> a scatterlist from its ->make_request_fn method.

This may not be possible but I really wanna avoid having two copies of
that complex logic.  Any chance blk_rq_map_bio() can be implemented in
a way that allows blk_rq_map_sg() can be built on top of it?  Also,
please include proper docbook style function comment on new public API
functions.

Thanks.

-- 
tejun
