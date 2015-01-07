From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] vhost/net: length miscalculation
Date: Wed, 07 Jan 2015 23:58:00 +0300
Message-ID: <54AD9DD8.2080008__24995.3358121731$1420664324$gmane$org@cogentembedded.com>
References: <1420620847-24477-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1420620847-24477-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hello.

On 01/07/2015 11:55 AM, Michael S. Tsirkin wrote:

> commit 8b38694a2dc8b18374310df50174f1e4376d6824
>      vhost/net: virtio 1.0 byte swap
> had this chunk:
> -       heads[headcount - 1].len += datalen;
> +       heads[headcount - 1].len = cpu_to_vhost32(vq, len - datalen);

> This adds datalen with the wrong sign, causing guest panics.

> Fixes: 8b38694a2dc8b18374310df50174f1e4376d6824

    The format of this tag assumes 12-digit SHA1 hash and the commit 
description enclosed in parens and double quotes. See 
Documentation/SubmittingPatches.

> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

WBR, Sergei
