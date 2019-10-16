From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC 1/2] vhost: IFC VF hardware operation layer
Date: Tue, 15 Oct 2019 19:06:49 -0700
Message-ID: <20191015190649.54ddc91c__31445.0740510196$1571191622$gmane$org@hermes.lan>
References: <20191016010318.3199-1-lingshan.zhu@intel.com>
	<20191016010318.3199-2-lingshan.zhu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016010318.3199-2-lingshan.zhu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhiyuan.lv@intel.com, jason.zeng@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 16 Oct 2019 09:03:17 +0800
Zhu Lingshan <lingshan.zhu@intel.com> wrote:

> +	IFC_INFO(&dev->dev, "PCI capability mapping:\n"
> +				"common cfg: %p\n"
> +				"notify base: %p\n"
> +				"isr cfg: %p\n"
> +				"device cfg: %p\n"
> +				"multiplier: %u\n",
> +				hw->common_cfg,
> +				hw->notify_base,
> +				hw->isr,
> +				hw->dev_cfg,
> +				hw->notify_off_multiplier);

Since kernel messages go to syslog, syslog does not handle multi-line
messages very well. This should be a single line.

Also, this is the kind of message that should be at the debug
level; something that is useful to the driver developers
but not something that needs to be filling up every end users log.
