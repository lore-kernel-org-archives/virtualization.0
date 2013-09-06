From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 3/7] Intel MIC Host Driver, card OS state
	management.
Date: Thu, 5 Sep 2013 22:01:57 -0700
Message-ID: <20130906050157.GF28806@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<669a3a3bbfff577c73d05fb568a810cbbc3d5333.1378423596.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <669a3a3bbfff577c73d05fb568a810cbbc3d5333.1378423596.git.sudeep.dutt@intel.com>
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

On Thu, Sep 05, 2013 at 04:41:55PM -0700, Sudeep Dutt wrote:
> +What:		/sys/class/mic/mic(x)/firmware
> +Date:		August 2013
> +KernelVersion:	3.11
> +Contact:	Sudeep Dutt <sudeep.dutt@intel.com>
> +Description:
> +		When read, this sysfs entry provides the path name under
> +		/lib/firmware/ where the firmware image to be booted on the
> +		card can be found. The entry can be written to change the
> +		firmware image location under /lib/firmware/.

I don't understand, is the path under the HOST device, or the Client
device's disk?  Why do you need to change the path on the HOST?  What's
wrong with the existing firmware path selection we have in the kernel?

thanks,

greg k-h
