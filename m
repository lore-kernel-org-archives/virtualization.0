From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 14:47:17 -0500
Message-ID: <4DF12345.1040409__4602.64075450159$1307648967$gmane$org@freescale.com>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<20110609124010.6335559e.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110609124010.6335559e.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: arnd@arndb.de, konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, dsaxena@linaro.org, linux-console@vger.kernel.org, greg@kroah.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
>> > +enum fsl_hv_ioctl_cmd {
>> > +	FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct fsl_hv_ioctl_restart),
>> > +	FSL_HV_IOCTL_PARTITION_GET_STATUS = _IOWR(0, 2, struct fsl_hv_ioctl_status),
>> > +	FSL_HV_IOCTL_PARTITION_START = _IOWR(0, 3, struct fsl_hv_ioctl_start),
>> > +	FSL_HV_IOCTL_PARTITION_STOP = _IOWR(0, 4, struct fsl_hv_ioctl_stop),
>> > +	FSL_HV_IOCTL_MEMCPY = _IOWR(0, 5, struct fsl_hv_ioctl_memcpy),
>> > +	FSL_HV_IOCTL_DOORBELL = _IOWR(0, 6, struct fsl_hv_ioctl_doorbell),
>> > +	FSL_HV_IOCTL_GETPROP = _IOWR(0, 7, struct fsl_hv_ioctl_prop),
>> > +	FSL_HV_IOCTL_SETPROP = _IOWR(0, 8, struct fsl_hv_ioctl_prop),
>> > +};

> Missing an entry in Documentation/ioctl/ioctl-number.txt for 0 (with conflict!).

If I change it from 0, I'm going to break binary compatibility with our apps.  I
agree that maybe I shouldn't have picked 0, but considering how many conflicts
there already are, I wonder what the point is.  Even if I pick a number that is
currently not listed in the chart, that doesn't mean that it's actually not
being used, or that it won't conflict in the future.

So is it okay to stick with 0, or do I need to pick a new number?

-- 
Timur Tabi
Linux kernel developer at Freescale
