From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] VirtioConsole support.
Date: Fri, 28 Oct 2011 18:27:59 +0200
Message-ID: <20111028162759.GA27263__20010.1017988802$1319820058$gmane$org@suse.de>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
	<20111027215535.GA5671@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111027215535.GA5671@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 27, 2011 at 05:55:35PM -0400, Konrad Rzeszutek Wilk wrote:
> On Thu, Oct 27, 2011 at 02:43:22PM -0700, Miche Baker-Harvey wrote:
> > Multiple HVC console terminals enabled.
> 
> Miche,
> 
> You might want to flesh out the description a bit. Perhaps include
> such details as : "fixes the infinite loop that git commit XX
> caused". Perhaps include some of the serial console output.
> 
> Maybe also change the title - the patch name (which is what shows up
> if you do 'git log --oneline') is 'VirtioConsole support.' which is
> not very informative.

Yes, all of these need to be resolved before I can accept this.

thanks,

greg k-h
