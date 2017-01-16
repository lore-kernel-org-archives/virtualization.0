From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2] virtio_console: fix a crash in config_work_handler
Date: Mon, 16 Jan 2017 15:57:23 +0530
Message-ID: <20170116102723.GM16209__14688.7011862875$1484562463$gmane$org@amit-lp.rh>
References: <20170116033550.GK16209@amit-lp.rh>
	<1484559902-5346-1-git-send-email-gcampana@quarkslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1484559902-5346-1-git-send-email-gcampana@quarkslab.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "G. Campana" <gcampana@quarkslab.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 16 Jan 2017 [10:45:02], G. Campana wrote:
> Using control_work instead of config_work as the 3rd argument to
> container_of results in an invalid portdev pointer. Indeed, the work
> structure is initialized as below:
> 
>     INIT_WORK(&portdev->config_work, &config_work_handler);
> 
> It leads to a crash when portdev->vdev is dereferenced later. This bug
> is triggered when the guest uses a virtio-console without multiport
> feature and receives a config_changed virtio interrupt.
> 
> Signed-off-by: G. Campana <gcampana@quarkslab.com>

Reviewed-by: Amit Shah <amit.shah@redhat.com>

Michael, can you please pick this up?

		Amit
