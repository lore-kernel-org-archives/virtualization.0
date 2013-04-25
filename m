From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9 0/3] tcm_vhost hotplug
Date: Thu, 25 Apr 2013 08:55:48 +0300
Message-ID: <20130425055548.GD6710@redhat.com>
References: <1366859406-8963-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366859406-8963-1-git-send-email-asias@redhat.com>
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

On Thu, Apr 25, 2013 at 11:10:03AM +0800, Asias He wrote:
> Asias He (3):
>   tcm_vhost: Refactor the lock nesting rule
>   tcm_vhost: Add hotplug/hotunplug support
>   tcm_vhost: Add ioctl to get and set events missed flag

For the series:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reported a minor formatting nit, we can
address these in tree as well.

>  drivers/vhost/tcm_vhost.c | 263 +++++++++++++++++++++++++++++++++++++++++++---
>  drivers/vhost/tcm_vhost.h |  13 +++
>  2 files changed, 260 insertions(+), 16 deletions(-)
> 
> -- 
> 1.8.1.4
