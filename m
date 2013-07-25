From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/5] Intel MIC Card Driver Changes for Virtio Devices.
Date: Wed, 24 Jul 2013 21:41:06 -0700
Message-ID: <20130725044106.GB11906@kroah.com>
References: <cover.1374717252.git.sudeep.dutt@intel.com>
	<ff721c257100467e8f78421ba9055b97e447551e.1374717252.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <ff721c257100467e8f78421ba9055b97e447551e.1374717252.git.sudeep.dutt@intel.com>
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
Cc: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, Harshavardhan R Kharche <harshavardhan.r.kharche@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Rob Landley <rob@landley.net>, Caz Yokoyama <Caz.Yokoyama@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 24, 2013 at 08:31:35PM -0700, Sudeep Dutt wrote:
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
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301
> + * USA.
> + *
> + * The full GNU General Public License is included in this distribution in
> + * the file called "COPYING".

Someone needs to tell Intel to take out the address paragraph of thier
"standard template" as it's annoying.  Please remove it, unless you
personally want to keep the file up to date with the address movements
of the FSF for the next 40+ years.

> + * Disclaimer: The codes contained in these modules may be specific to
> + * the Intel Software Development Platform codenamed: Knights Ferry, and
> + * the Intel product codenamed: Knights Corner, and are not backward
> + * compatible with other Intel products. Additionally, Intel will NOT
> + * support the codes or instruction set in future products.

What does this mean?  That's a new one to me...

> +static inline struct device *dev(struct mic_vdev *mvdev)
> +{
> +	return mvdev->vdev.dev.parent;
> +}

Can you pick a worse name?  And you aren't returning the "device", you
are returning the parent, so the name (as short as it is), is wrong.


ick.

greg k-h
