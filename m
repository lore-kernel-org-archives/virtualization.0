From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/7] Intel MIC Host Driver for X100 family.
Date: Mon, 12 Aug 2013 15:58:48 -0700
Message-ID: <20130812225848.GA30952__1276.35930334709$1376348341$gmane$org@kroah.com>
References: <cover.1375927849.git.sudeep.dutt@intel.com>
	<a5214cbe041674f0b5dcd7eb9b581b4d7f923947.1375927849.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a5214cbe041674f0b5dcd7eb9b581b4d7f923947.1375927849.git.sudeep.dutt@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, AsiasHeasias@redhat.com, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 07, 2013 at 08:04:07PM -0700, Sudeep Dutt wrote:
> diff --git a/drivers/misc/mic/host/mic_common.h b/drivers/misc/mic/host/mic_common.h
> new file mode 100644
> index 0000000..55b0337
> --- /dev/null
> +++ b/drivers/misc/mic/host/mic_common.h
> @@ -0,0 +1,30 @@
> +/*
> + * Intel MIC Platform Software Stack (MPSS)
> + *
> + * Copyright(c) 2013 Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * The full GNU General Public License is included in this distribution in
> + * the file called "COPYING".
> + *
> + * Intel MIC Host driver.
> + *
> + */
> +#ifndef _MIC_HOST_COMMON_H_
> +#define _MIC_HOST_COMMON_H_
> +
> +#include <linux/cdev.h>
> +
> +#include "../common/mic_device.h"
> +#include "mic_device.h"
> +#include "mic_x100.h"
> +
> +#endif

Don't create .h files that just wrap other .h files up.  It makes it
hard to unwind stuff and determine exactly what .c files need what .h
files.  Just include the needed .h files properly in the .c code, and
all should be fine.

thanks,

greg k-h
