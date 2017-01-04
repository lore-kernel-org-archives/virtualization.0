From: Michal Hocko <mhocko@kernel.org>
Subject: Re: GFP_REPEAT usage in vhost_net_open resp. vhost_vsock_dev_open
Date: Wed, 4 Jan 2017 19:06:24 +0100
Message-ID: <20170104180624.GA10183__29027.6694148362$1483553202$gmane$org@dhcp22.suse.cz>
References: <20170104150800.GO25453@dhcp22.suse.cz>
	<20170104195521-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170104195521-mutt-send-email-mst@kernel.org>
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
Cc: linux-mm@kvack.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed 04-01-17 19:56:42, Michael S. Tsirkin wrote:
> On Wed, Jan 04, 2017 at 04:08:00PM +0100, Michal Hocko wrote:
> > Hi Michael,
> > I am currently cleaning up opencoded kmalloc with vmalloc fallback users
> > [1] and my current kvmalloc_node helper doesn't support GFP_REPEAT
> > because there are no users which would need it. At least that's what I
> > thought until I've encountered vhost_vsock_dev_open resp.
> > vhost_vsock_dev_open which are trying to use GFP_REPEAT for kmalloc.
> > 23cc5a991c7a ("vhost-net: extend device allocation to vmalloc") explains
> > the motivation as follows:
> > "
> > As vmalloc() adds overhead on a critical network path, add __GFP_REPEAT
> > to kzalloc() flags to do this fallback only when really needed.
> > "
> > 
> > I am wondering whether vmalloc adds more overhead than GFP_REPEAT
> 
> Yes but the GFP_REPEAT overhead is during allocation time.
> Using vmalloc means all accesses are slowed down.
> Allocation is not on data path, accesses are.

OK, that wasn't clear to me. Thanks for the clarification. If the access
path can compensate the allocation cost then I agree that GFP_REPEAT
makes a lot of sense. I will cook up a patch to allow GFP_REPEAT in the
current kvmalloc_node and convert vhost users to it.

Thanks!

-- 
Michal Hocko
SUSE Labs
