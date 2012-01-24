From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 4/4] xen kconfig: describe xen tmem in the
	config menu
Date: Tue, 24 Jan 2012 12:38:27 -0500
Message-ID: <20120124173827.GA10434@phenom.dumpdata.com>
References: <1325842991-4404-1-git-send-email-drjones@redhat.com>
	<1325842991-4404-5-git-send-email-drjones@redhat.com>
	<20120123183454.GA12542@phenom.dumpdata.com>
	<4F1E6C17.7060609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F1E6C17.7060609@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, xen-devel@lists.xensource.com, jeremy@goop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 24, 2012 at 09:30:15AM +0100, Igor Mammedov wrote:
> On 01/23/2012 07:34 PM, Konrad Rzeszutek Wilk wrote:
> >On Fri, Jan 06, 2012 at 10:43:11AM +0100, Andrew Jones wrote:
> >>Add a description to the config menu for xen tmem.
> >
> >I am not sure what this patch gets us. If this is to minimize the
> >size of the module - so say it gets loaded, but tmem-enabled is
> >not set nor cleancache and we just have it consuming memory - we can do it
> >via returning -ENODEV on the module load.
> 
> But why compile in something that one may never use? At least with this patch
> I'll have a choice to turn it off if I don't need it.

Then this patch is misleading. It should state at the start
what its purpose is. It sounds like adding the description is just
a way for the real purpose of this patch - which is to disable tmem.

> For example when I build hardened kernel, I'd like to turn of all unnecessary
> features for a particular config (i.e. reduce attack surface as much as possible).

The 'tmem' gets turned off if you disable cleancache. Can't you just
disable cleancache in your hardened config?
