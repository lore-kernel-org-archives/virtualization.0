From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Tue, 31 Jul 2012 16:43:14 +0800
Message-ID: <50179AA2.5040708@redhat.com>
References: <971756309.4742543.1343457753475.JavaMail.root@redhat.com>
	<501610E0.8000504@redhat.com> <20120730134322.GB6041@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120730134322.GB6041@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/30/2012 09:43 PM, Christoph Hellwig wrote:
> On Mon, Jul 30, 2012 at 12:43:12PM +0800, Asias He wrote:
>> I think we can add REQ_FLUSH & REQ_FUA support to bio path and that
>> deserves another patch.
>
> Adding it is a requirement for merging the code.
>

OK. Will add that.

-- 
Asias
