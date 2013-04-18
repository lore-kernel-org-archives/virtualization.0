From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 0/3] tcm_vhost hotplug
Date: Thu, 18 Apr 2013 10:36:05 +0300
Message-ID: <20130418073605.GF13787@redhat.com>
References: <20130417131726.GA26157@redhat.com>
	<1366247154-3136-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366247154-3136-1-git-send-email-asias@redhat.com>
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

On Thu, Apr 18, 2013 at 09:05:51AM +0800, Asias He wrote:
> Changes in v7:
> - Add vhost_work_flush for vs->vs_event_work to this series
> 
> Asias He (3):
>   tcm_vhost: Introduce tcm_vhost_check_feature()
>   tcm_vhost: Add helper to check if endpoint is setup
>   tcm_vhost: Add hotplug/hotunplug support

Okay it looks like I missed some issues in the previous
review round. Sorry about that. Sent more comments now.

They are kind of minor so if already applied,
we can fix them incrementally I think.

>  drivers/vhost/tcm_vhost.c | 238 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/vhost/tcm_vhost.h |  10 ++
>  2 files changed, 244 insertions(+), 4 deletions(-)
> 
> -- 
> 1.8.1.4
