From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH v2 0/4] tcm_vhost fix cmd leak and send bad target
Date: Wed, 10 Apr 2013 14:19:02 -0700
Message-ID: <1365628742.3588.11.camel@haakon2.linux-iscsi.org>
References: <1365564191-20928-1-git-send-email-asias@redhat.com>
	<1365577576-26183-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365577576-26183-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-04-10 at 15:06 +0800, Asias He wrote:
> v2:
> - Fix the order of out and head parameter.
> 
> Asias He (4):
>   tcm_vhost: Remove double check of response
>   tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq
>   tcm_vhost: Add vhost_scsi_send_bad_target() helper
>   tcm_vhost: Send bad target to guest when cmd fails
> 
>  drivers/vhost/tcm_vhost.c | 53 +++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
> 

Looks good.  MST, care to ACK for 3.9..?

Thanks Asias!

--nab
