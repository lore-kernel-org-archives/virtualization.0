From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 5/5] virtio-scsi: introduce multiqueue support
Date: Wed, 19 Dec 2012 12:27:18 +0100
Message-ID: <20121219112718.GB5832__29862.4411494986$1355939795$gmane$org@stefanha-thinkpad.redhat.com>
References: <1355833972-20319-1-git-send-email-pbonzini@redhat.com>
	<1355833972-20319-6-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1355833972-20319-6-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-scsi@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, hutao@cn.fujitsu.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 18, 2012 at 01:32:52PM +0100, Paolo Bonzini wrote:
>  struct virtio_scsi_target_state {
> -	/* Never held at the same time as vq_lock.  */
> +	/* This spinlock ever held at the same time as vq_lock.  */

s/ever/is never/
