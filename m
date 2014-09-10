From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio_blk: merge S/G list entries by default
Date: Wed, 10 Sep 2014 17:18:23 +0200
Message-ID: <54106BBF.7010907@redhat.com>
References: <1410044994-14943-1-git-send-email-hch@lst.de>
	<CACVXFVMRqgEh7EFQ0cDEatsqtxsgBrbSQNH9b6UZTsSD+=OWdA__14121.5735966854$1410309057$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVMRqgEh7EFQ0cDEatsqtxsgBrbSQNH9b6UZTsSD+=OWdA__14121.5735966854$1410309057$gmane$org@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Il 07/09/2014 12:32, Ming Lei ha scritto:
> It is a good idea to disable SG merge for vq incapable of indirect because
> there are very limited direct descriptors.

I think you mean _enabling_ SG merge if indirect descriptors are not there.

> For vq capable of indirect, it should be better to not do SG merge at default
> because:
> 
> - from hypervisor view, no matter how many segments one req has, all are
> submitted to host kernel by one syscall, such as readv/io_submit
> 
> - host kernel still need to do the same merge again

Here we agree.

Paolo

> From my test(virtio-blk over null_blk), looks enabling SG merge may cause
> throughput a little drop(~3%).
