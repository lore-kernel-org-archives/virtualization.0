From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Fri, 6 Sep 2013 13:52:35 +0530
Message-ID: <20130906082235.GE29367__41737.1698226363$1378455773$gmane$org@grmbl.mre>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 06 Sep 2013 [16:20:05], Aaron Lu wrote:
> This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
> drivers and virtio pci driver.
> 
> With patch 1/2, two compile warnings are eliminated for virtio pci
> driver, and patch 2/2 is a clean up for all virtio drivers as suggested
> by Amit Shah.

Thank you.

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
