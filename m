From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 15:18:28 -0500
Message-ID: <4DF12A94.6070605__32283.9347216815$1307651046$gmane$org@freescale.com>
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<201106092213.13755.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201106092213.13755.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: konrad.wilk@oracle.com, benh@kernel.crashing.org, kumar.gala@freescale.com, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-console@vger.kernel.org, greg@kroah.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> As mentioned, it would be easier and more readable to just do
> 
> 	switch(cmd) {
> 	case FSL_HV_IOCTL_PARTITION_RESTART:
> 		...
> 
> 	case FSL_HV_IOCTL_PARTITION_GET_STATUS;
> 		...
> 
> There is no need to check the bits individually when you can simply
> compare the command number.

But this will break backwards compatibility with older applications that used
the union as the size parameter.  Although these applications won't compile with
the new header file, older already-compiled applications still work.

I will eventually update the applications to use the new header file, and at
that point I will modify the switch statement as you suggest.  But until then,
I'd like to keep the code as-is.

>> > +enum fsl_hv_ioctl_cmd {
>> > +       FSL_HV_IOCTL_PARTITION_RESTART = _IOWR(0, 1, struct fsl_hv_ioctl_restart),
>> > +       FSL_HV_IOCTL_PARTITION_GET_STATUS = _IOWR(0, 2, struct fsl_hv_ioctl_status),
>> > +       FSL_HV_IOCTL_PARTITION_START = _IOWR(0, 3, struct fsl_hv_ioctl_start),
>> > +       FSL_HV_IOCTL_PARTITION_STOP = _IOWR(0, 4, struct fsl_hv_ioctl_stop),
>> > +       FSL_HV_IOCTL_MEMCPY = _IOWR(0, 5, struct fsl_hv_ioctl_memcpy),
>> > +       FSL_HV_IOCTL_DOORBELL = _IOWR(0, 6, struct fsl_hv_ioctl_doorbell),
>> > +       FSL_HV_IOCTL_GETPROP = _IOWR(0, 7, struct fsl_hv_ioctl_prop),
>> > +       FSL_HV_IOCTL_SETPROP = _IOWR(0, 8, struct fsl_hv_ioctl_prop),
>> > +};

> Using a #define here is usually preferred because then you can use #ifdef in a user
> application to check if a given value has been assigned.

You're right -- I had enum on the brain.

> More importantly, the code you have chose (0) conflicts with existing drivers
> (frame buffer, scsi and wavefront among others). Please chose a free one and
> add it to Documentation/ioctl/ioctl-number.txt in the same patch.

Ok, I was really hoping to avoid doing this.  Like I said, binary compatibility
is important, and changing the type will break my existing apps.  Are you
insisting that I pick a new number?

-- 
Timur Tabi
Linux kernel developer at Freescale
