From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/2] xen/xenbus: don't reimplement kvasprintf
	via a fixed size buffer
Date: Wed, 4 Jan 2012 10:12:49 -0500
Message-ID: <20120104151249.GF3322@phenom.dumpdata.com>
References: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
	<1325677192-10459-2-git-send-email-ian.campbell@citrix.com>
	<4F044D10020000780006A5B4@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F044D10020000780006A5B4@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Campbell <ian.campbell@citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Haogang Chen <haogangchen@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 04, 2012 at 11:58:56AM +0000, Jan Beulich wrote:
> >>> On 04.01.12 at 12:39, Ian Campbell <ian.campbell@citrix.com> wrote:
> > Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> 
> Acked-by: Jan Beulich <jbeulich@suse.com>

OK, took:

Ian Campbell (3):
      xen/xenbus: Reject replies with payload > XENSTORE_PAYLOAD_MAX.
      xenbus: maximum buffer size is XENSTORE_PAYLOAD_MAX
      xen/xenbus: don't reimplement kvasprintf via a fixed size buffer

And put the ' xen/xenbus: Reject replies with payload > XENSTORE_PAYLOAD_MAX'
on the stable@kernel.org as well.

Thanks!
