From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 0/7] Enable Drivers for Intel MIC X100
	Coprocessors.
Date: Thu, 26 Sep 2013 13:53:58 -0700
Message-ID: <20130926205358.GA19455@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1378423596.git.sudeep.dutt@intel.com>
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

On Thu, Sep 05, 2013 at 04:41:20PM -0700, Sudeep Dutt wrote:
> ChangeLog:
> =========
> 
> v2 => v3:
> a) Patch 1 data structure cleanups, header file include cleanups,
>    IDA interface reuse and switching to device_create_with_groups(..)
>    as per feedback from Greg Kroah-Hartman.
> b) Patch 7 signal documentation, sleep workaround removal and sysfs
>    access API cleanups as per feedback from Michael S. Tsirkin.

Now applied, thanks.

Note, I'm getting some odd warnings about the uapi .h files when doing a
build, so a follow-on patch to fix those up would be appreciated, along
with the other minor cleanups I discussed with you previously.

thanks,

greg k-h
