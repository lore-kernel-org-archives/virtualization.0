From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [kvm-devel] [PATCH] QEMU KVM balloon support
Date: Tue, 8 Jan 2008 15:08:27 -0200
Message-ID: <20080108170827.GA22747__3952.06901380352$1199824194$gmane$org@dmt>
References: <20080108154340.GC21726@dmt> <20080108164342.GF21294@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080108164342.GF21294@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2008 at 04:43:42PM +0000, Daniel P. Berrange wrote:
> On Tue, Jan 08, 2008 at 01:43:40PM -0200, Marcelo Tosatti wrote:
> > Index: kvm-userspace/qemu/monitor.c
> > ===================================================================
> > --- kvm-userspace.orig/qemu/monitor.c
> > +++ kvm-userspace/qemu/monitor.c
> > @@ -1339,6 +1339,8 @@ static term_cmd_t term_cmds[] = {
> >        "", "cancel the current VM migration" },
> >      { "migrate_set_speed", "s", do_migrate_set_speed,
> >        "value", "set maximum speed (in bytes) for migrations" },
> > +    { "setmem", "s", do_setmemory, "value", 
> > +      "set memory for the guest (in bytes)" },
> >      { NULL, NULL, },
> >  };
> 
> [snip]
> 
> > +void do_setmemory(const char *value)
> > +{
> > +	int target_ramsize;
> > +	char *ptr;
> > +
> > +	target_ramsize = strtol(value, &ptr, 10);
> > +	switch (*ptr) {
> > +	case 'G': case 'g':
> > +		target_ramsize *= 1024;
> > +	case 'M': case 'm':
> > +		target_ramsize *= 1024;
> > +	case 'K': case 'k':
> > +		target_ramsize *= 1024;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	if (target_ramsize > ram_size) {
> > +		term_printf("Invalid RAM size, maximum: %d\n", ram_size);
> > +		return;
> > +	}
> > +	
> > +	balloon_update_target(target_ramsize);
> > +}
> 
> Shouldn't this use  int64, and strtoll(), otherwise you'll wrap
> at the 2 GB mark ?

Good catch, thanks.
