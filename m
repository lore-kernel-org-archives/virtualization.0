From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V4 0/2] tcm_vhost hotplug
Date: Mon, 08 Apr 2013 14:31:27 -0700
Message-ID: <1365456687.24346.96.camel@haakon2.linux-iscsi.org>
References: <1363930745-7520-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-03-22 at 13:39 +0800, Asias He wrote:
> Asias He (2):
>   tcm_vhost: Introduce tcm_vhost_check_feature()
>   tcm_vhost: Add hotplug/hotunplug support
> 
>  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/tcm_vhost.h |  10 +++
>  2 files changed, 229 insertions(+), 5 deletions(-)
> 

Hi MST,

With vhost-scsi-pci now on the right track for upstream QEMU, will you
consider this code as a v3.10 item..?

Asias, I assume this will need to be rebased against your latest patches
in target-pending/master, yes..?

--nab
