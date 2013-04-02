From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2 V3] virtio-spec/net: dynamic network offloads
	configuration
Date: Tue, 2 Apr 2013 14:57:57 +0300
Message-ID: <20130402115757.GA22131@redhat.com>
References: <1364902740-24948-1-git-send-email-dmitry@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1364902740-24948-1-git-send-email-dmitry@daynix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Ronen Hod <rhod@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 02, 2013 at 02:38:58PM +0300, Dmitry Fleytman wrote:
> From: Dmitry Fleytman <dfleytma@redhat.com>
> 
> V3 changes:
>   1. Compat macro added
>   2. Feature name beautification
> 
> V2 changes:
>   1. _GUEST_ added to command and feature names
>   2. Live migration logic fixed
> 
> Reported-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Rusty?

> One of recently introduced Windows features (RSC)
> requires network driver to be able to enable and disable
> HW LRO offload on the fly without device reinitialization.
> 
> Current Virtio specification doesn't support this requirement.
> The solution proposed by following spec patch is to add
> a new control command for this purpose.
> 
> The same solution may be used in Linux driver for ethtool interface
> implementation.
> 
> Patch for QEMU mainline that implements this specification change
> attached as well.
> 
> -- 
> 1.8.1.4
