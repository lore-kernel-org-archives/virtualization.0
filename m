From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Fri, 3 Aug 2012 08:13:09 -0300
Message-ID: <20120803111309.GA1848@t510.redhat.com>
References: <cover.1342485774.git.aquini@redhat.com>
	<49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
	<20120718054824.GA32341@bbox>
	<20120720194858.GA16249@t510.redhat.com>
	<20120723023332.GA6832@bbox>
	<20120723181952.GA27373@t510.redhat.com>
	<5019975B.6010708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5019975B.6010708@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 01, 2012 at 04:53:47PM -0400, Rik van Riel wrote:
> On 07/23/2012 02:19 PM, Rafael Aquini wrote:
> 
> >In a glance, I believe this whole dance you're suggesting might just be too much
> >of an overcomplication, and the best approach would be simply teaching the
> >hotplug bits about the ballooned corner case just like it's being done to
> >compaction/migration. However, I'll look at it carefully before making any other
> >adjustments/propositions over here.
> 
> Compaction and hotplug do essentially the same thing
> here: "collect all the movable pages from a page block,
> and move them elsewhere".
> 
> Whether or not it is easier for them to share code, or
> to duplicate a few lines of code, is something that can
> be looked into later.

I'm 100% in agreement with your thoughts here.
