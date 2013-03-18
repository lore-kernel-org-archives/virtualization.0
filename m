From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 0/2] tcm_vhost hotplug/hotunplug support
Date: Mon, 18 Mar 2013 23:53:50 +0200
Message-ID: <20130318215350.GA21091@redhat.com>
References: <1363056339-6061-1-git-send-email-asias@redhat.com>
	<1363643172.3156.62.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363643172.3156.62.camel@haakon2.linux-iscsi.org>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 18, 2013 at 02:46:12PM -0700, Nicholas A. Bellinger wrote:
> On Tue, 2013-03-12 at 10:45 +0800, Asias He wrote:
> > Changes in v3:
> > - Separate the bug fix to another thread
> > 
> > Changes in v2:
> > - Remove code duplication in tcm_vhost_{hotplug,hotunplug}
> > - Fix racing of vs_events_nr
> > - Add flush fix patch to this series
> > 
> > 
> > Asias He (2):
> >   tcm_vhost: Introduce tcm_vhost_check_feature()
> >   tcm_vhost: Add hotplug/hotunplug support
> > 
> >  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/tcm_vhost.h |  10 +++
> >  2 files changed, 229 insertions(+), 5 deletions(-)
> > 
> 
> MST, are you OK with these two being applied to target-pending/for-next
> now..?
> 
> --nab

Sorry, no, I'd prefer we get userspace support in qemu in first.
If there's only a single user for this driver (kvmtool),
then it was a mistake to merge it, the right thing would be to freeze it
and look at whether we can drop it completely.

I really don't want this, I hope it will be merged and all will
be shiny, but I think it's wrong to rush in more code,
we have some time before the next merge window.

-- 
MST
