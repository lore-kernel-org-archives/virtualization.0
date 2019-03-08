From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Fri, 8 Mar 2019 06:12:20 -0800
Message-ID: <20190308141220.GA21082__29458.7094731227$1552054352$gmane$org@infradead.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: aarcange@redhat.com, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2019 at 02:18:07AM -0500, Jason Wang wrote:
> This series tries to access virtqueue metadata through kernel virtual
> address instead of copy_user() friends since they had too much
> overheads like checks, spec barriers or even hardware feature
> toggling. This is done through setup kernel address through vmap() and
> resigter MMU notifier for invalidation.
> 
> Test shows about 24% improvement on TX PPS. TCP_STREAM doesn't see
> obvious improvement.

How is this going to work for CPUs with virtually tagged caches?
