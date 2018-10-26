From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Date: Fri, 26 Oct 2018 01:26:40 -0700
Message-ID: <20181026082640.GA1147@infradead.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20181012210628.226361-1-dverkamp@chromium.org>
	<20181015092740.GA3964@infradead.org>
	<486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 26, 2018 at 01:28:54AM +0200, Paolo Bonzini wrote:
> On 15/10/2018 11:27, Christoph Hellwig wrote:
> > There is some issues in this spec.  For one using the multiple ranges
> > also for write zeroes is rather inefficient.  Write zeroes really should
> > use the same format as read and write.
> 
> What makes it inefficient?

We require a memory allocation for each write zeroes instead of encoding
the lba/len in the command.
