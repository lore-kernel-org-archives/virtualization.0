From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio-rng: fix stuck of hot-unplugging busy device
Date: Wed, 10 Sep 2014 12:33:54 +0530
Message-ID: <20140910070354.GC29832@grmbl.mre>
References: <1410329497-14349-1-git-send-email-akong@redhat.com>
	<1410329497-14349-2-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1410329497-14349-2-git-send-email-akong@redhat.com>
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

On (Wed) 10 Sep 2014 [14:11:36], Amos Kong wrote:
> When we try to hot-remove a busy virtio-rng device from QEMU monitor,
> the device can't be hot-removed. Because virtio-rng driver hangs at
> wait_for_completion_killable().
> 
> This patch exits the waiting by completing have_data completion before
> unregistering, resets data_avail to avoid the hwrng core use wrong
> buffer bytes.
> 
> Signed-off-by: Amos Kong <akong@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
