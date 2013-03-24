From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 0/2] tcm_vhost hotplug
Date: Sun, 24 Mar 2013 17:20:54 +0200
Message-ID: <20130324152054.GC8657@redhat.com>
References: <1363930745-7520-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363930745-7520-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 22, 2013 at 01:39:03PM +0800, Asias He wrote:
> Asias He (2):
>   tcm_vhost: Introduce tcm_vhost_check_feature()
>   tcm_vhost: Add hotplug/hotunplug support

So this work should stay out of tree until we have
2 users for vhost-scsi, but I sent some comment to
help you make progress.

>  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/tcm_vhost.h |  10 +++
>  2 files changed, 229 insertions(+), 5 deletions(-)
> 
> -- 
> 1.8.1.4
