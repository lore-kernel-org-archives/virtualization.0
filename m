From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RESEND v3 1/7] Intel MIC Host Driver for X100 family.
Date: Thu, 5 Sep 2013 21:57:22 -0700
Message-ID: <20130906045722.GC28806__7604.73248451508$1378443289$gmane$org@kroah.com>
References: <cover.1378423596.git.sudeep.dutt@intel.com>
	<8b972a444f4529ecffc718db4112aa8959bf72ad.1378423596.git.sudeep.dutt@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8b972a444f4529ecffc718db4112aa8959bf72ad.1378423596.git.sudeep.dutt@intel.com>
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

On Thu, Sep 05, 2013 at 04:41:31PM -0700, Sudeep Dutt wrote:
>  drivers/misc/mic/common/mic_device.h          |  37 +++
>  drivers/misc/mic/host/mic_device.h            | 109 +++++++++

Two different files, with the same name?  You are asking for trouble in
the future, getting them confused :)

Please try to pick a unique name, especially when you later do things
like:

> +#include "../common/mic_device.h"
> +#include "mic_device.h"

Which just looks odd.

Again, not a big deal, follow-on patch can fix this.

thanks,

greg k-h
