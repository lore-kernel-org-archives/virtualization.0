From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [Xen-devel] [PATCH 4/4] xen kconfig: describe xen tmem in the
	config menu
Date: Tue, 24 Jan 2012 09:30:15 +0100
Message-ID: <4F1E6C17.7060609__23010.4260649115$1327424646$gmane$org@redhat.com>
References: <1325842991-4404-1-git-send-email-drjones@redhat.com>
	<1325842991-4404-5-git-send-email-drjones@redhat.com>
	<20120123183454.GA12542@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120123183454.GA12542@phenom.dumpdata.com>
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
Cc: Andrew Jones <drjones@redhat.com>, xen-devel@lists.xensource.com, jeremy@goop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 01/23/2012 07:34 PM, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 06, 2012 at 10:43:11AM +0100, Andrew Jones wrote:
>> Add a description to the config menu for xen tmem.
>
> I am not sure what this patch gets us. If this is to minimize the
> size of the module - so say it gets loaded, but tmem-enabled is
> not set nor cleancache and we just have it consuming memory - we can do it
> via returning -ENODEV on the module load.

But why compile in something that one may never use? At least with this patch
I'll have a choice to turn it off if I don't need it.
For example when I build hardened kernel, I'd like to turn of all unnecessary
features for a particular config (i.e. reduce attack surface as much as possible).

-- 
Thanks,
  Igor
