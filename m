From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v2 3/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Tue, 29 Jan 2013 11:21:07 -0800
Message-ID: <1359487267.23290.1437.camel__41708.8682101623$1359487291$gmane$org@haakon2.linux-iscsi.org>
References: <1358824827-16169-1-git-send-email-asias@redhat.com>
	<1358824827-16169-4-git-send-email-asias@redhat.com>
	<1359485613.23290.1389.camel@haakon2.linux-iscsi.org>
	<20130129191659.GA29615@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130129191659.GA29615@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-01-29 at 21:16 +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 29, 2013 at 10:53:33AM -0800, Nicholas A. Bellinger wrote:
> > On Tue, 2013-01-22 at 11:20 +0800, Asias He wrote:
> > > We can get all the pages in one time instead of calling
> > > gup N times.
> > > 
> > > Signed-off-by: Asias He <asias@redhat.com>
> > > ---
> > 
> > Everything looks fine after initial testing, so also applied to
> > target-pending/for-next.
> > 
> > Nice optimization.  :)
> > 
> > --nab
> 
> Maybe best if you put the llist optimization on that branch too then?
> 

<nod>, already applied that one ahead of this series.

--nab
