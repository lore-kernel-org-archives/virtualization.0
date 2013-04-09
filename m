From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V4 0/2] tcm_vhost hotplug
Date: Tue, 9 Apr 2013 08:57:56 +0800
Message-ID: <20130409005756.GA26647@hj.localdomain>
References: <1363930745-7520-1-git-send-email-asias@redhat.com>
	<1365456687.24346.96.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1365456687.24346.96.camel@haakon2.linux-iscsi.org>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 08, 2013 at 02:31:27PM -0700, Nicholas A. Bellinger wrote:
> On Fri, 2013-03-22 at 13:39 +0800, Asias He wrote:
> > Asias He (2):
> >   tcm_vhost: Introduce tcm_vhost_check_feature()
> >   tcm_vhost: Add hotplug/hotunplug support
> > 
> >  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/tcm_vhost.h |  10 +++
> >  2 files changed, 229 insertions(+), 5 deletions(-)
> > 
> 
> Hi MST,
> 
> With vhost-scsi-pci now on the right track for upstream QEMU, will you
> consider this code as a v3.10 item..?
> 
> Asias, I assume this will need to be rebased against your latest patches
> in target-pending/master, yes..?

I will rebase this one and the flush one shortly.

> --nab
> 

-- 
Asias
