From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/3] tcm_vhost: Optimize gup in vhost_scsi_map_to_sgl
Date: Tue, 29 Jan 2013 21:16:59 +0200
Message-ID: <20130129191659.GA29615@redhat.com>
References: <1358824827-16169-1-git-send-email-asias@redhat.com>
	<1358824827-16169-4-git-send-email-asias@redhat.com>
	<1359485613.23290.1389.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1359485613.23290.1389.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 29, 2013 at 10:53:33AM -0800, Nicholas A. Bellinger wrote:
> On Tue, 2013-01-22 at 11:20 +0800, Asias He wrote:
> > We can get all the pages in one time instead of calling
> > gup N times.
> > 
> > Signed-off-by: Asias He <asias@redhat.com>
> > ---
> 
> Everything looks fine after initial testing, so also applied to
> target-pending/for-next.
> 
> Nice optimization.  :)
> 
> --nab

Maybe best if you put the llist optimization on that branch too then?
