From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 2/2] virtio-rng: skip reading when we start to remove
	the device
Date: Wed, 10 Sep 2014 12:34:44 +0530
Message-ID: <20140910070444.GD29832@grmbl.mre>
References: <1410329497-14349-1-git-send-email-akong@redhat.com>
	<1410329497-14349-3-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410329497-14349-3-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 10 Sep 2014 [14:11:37], Amos Kong wrote:
> Before we really unregister the hwrng device, reading will get stuck if
> the virtio device is reset. We should return error for reading when we
> start to remove the device.
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
