From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Tue, 14 Aug 2012 23:24:01 +0300
Message-ID: <20120814202401.GB28990__38356.7776684233$1344975800$gmane$org@redhat.com>
References: <cover.1344619987.git.aquini@redhat.com>
	<f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814195916.GC28870@redhat.com>
	<20120814200830.GD22133@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814200830.GD22133@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 05:08:31PM -0300, Rafael Aquini wrote:
> On Tue, Aug 14, 2012 at 10:59:16PM +0300, Michael S. Tsirkin wrote:
> > > > > What if there is more than one balloon device?
> > > > 
> > > > Is it possible to load this driver twice, or are you foreseeing a future case
> > > > where this driver will be able to manage several distinct memory balloons for
> > > > the same guest?
> > > > 
> > > 
> > > Second.
> > > It is easy to create several balloons they are just
> > > pci devices.
> >  
> > 
> > 
> > and it might not be too important to make it work but
> > at least would be nice not to have a crash in this
> > setup.
> >
> Fair enough. For now, as I believe it's safe to assume we are only inflating one
> balloon per guest, I'd like to propose this as a future enhancement. Sounds
> good?
>  

Since guest crashes when it's not the case, no it doesn't, sorry :(.
