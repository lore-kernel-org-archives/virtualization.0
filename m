From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 7/9] vhost: do not use RCU to synchronize MMU notifier
	with worker
Date: Tue, 6 Aug 2019 09:36:58 -0400
Message-ID: <20190806093633-mutt-send-email-mst__48922.3655940563$1565098637$gmane$org@kernel.org>
References: <a3bde826-6329-68e4-2826-8a9de4c5bd1e@redhat.com>
	<20190801141512.GB23899@ziepe.ca>
	<42ead87b-1749-4c73-cbe4-29dbeb945041@redhat.com>
	<20190802124613.GA11245@ziepe.ca>
	<20190802100414-mutt-send-email-mst@kernel.org>
	<20190802172418.GB11245@ziepe.ca>
	<20190803172944-mutt-send-email-mst@kernel.org>
	<20190804001400.GA25543@ziepe.ca>
	<20190804040034-mutt-send-email-mst@kernel.org>
	<20190806115317.GA11627@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190806115317.GA11627@ziepe.ca>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 06, 2019 at 08:53:17AM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 04, 2019 at 04:07:17AM -0400, Michael S. Tsirkin wrote:
> > > > > Also, why can't this just permanently GUP the pages? In fact, where
> > > > > does it put_page them anyhow? Worrying that 7f466 adds a get_user page
> > > > > but does not add a put_page??
> > > 
> > > You didn't answer this.. Why not just use GUP?
> > > 
> > > Jason
> > 
> > Sorry I misunderstood the question. Permanent GUP breaks lots of
> > functionality we need such as THP and numa balancing.
> 
> Really? It doesn't look like that many pages are involved..
> 
> Jason

Yea. But they just might happen to be heavily accessed ones....

-- 
MST
