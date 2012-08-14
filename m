From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v7 1/4] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Tue, 14 Aug 2012 17:03:27 -0300
Message-ID: <20120814200326.GC22133__25865.9094492488$1344974627$gmane$org@t510.redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
	<292b1b52e863a05b299f94bda69a61371011ac19.1344619987.git.aquini@redhat.com>
	<20120813082619.GE14081@redhat.com>
	<20120814174404.GA13338@t510.redhat.com>
	<20120814193525.GB28840@redhat.com>
	<20120814194837.GA28863@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814194837.GA28863@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 10:48:37PM +0300, Michael S. Tsirkin wrote:
> > 
> > E.g. kvm can emulate hyperv so it could in theory have hyperv balloon.
> > This is mm stuff it is best not to tie it to specific drivers.
> 
> But of course I agree this is not top priority, no need
> to block submission on this, just nice to have.
>
This surely is interesting to look at, in the near future. 
