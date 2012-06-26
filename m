From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 26 Jun 2012 19:57:55 -0400
Message-ID: <20120626235754.GB14782__8054.37999447367$1340755087$gmane$org@localhost.localdomain>
References: <cover.1340665087.git.aquini@redhat.com>
	<7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7f83427b3894af7969c67acc0f27ab5aa68b4279.1340665087.git.aquini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

> +#if defined(CONFIG_VIRTIO_BALLOON) || defined(CONFIG_VIRTIO_BALLOON_MODULE)
> +/*
> + * Balloon pages special page->mapping.
> + * users must properly allocate and initiliaze an instance of balloon_mapping,

initialize

> + * and set it as the page->mapping for balloon enlisted page instances.
> + *
> + * address_space_operations necessary methods for ballooned pages:
> + *   .migratepage    - used to perform balloon's page migration (as is)
> + *   .invalidatepage - used to isolate a page from balloon's page list
> + *   .freepage       - used to reinsert an isolated page to balloon's page list
> + */
> +struct address_space *balloon_mapping;
> +EXPORT_SYMBOL(balloon_mapping);

Why don't you call this kvm_balloon_mapping - and when other balloon
drivers use it, then change it to something more generic. Also at that
future point the other balloon drivers might do it a bit differently so
it might be that will be reworked completly.
