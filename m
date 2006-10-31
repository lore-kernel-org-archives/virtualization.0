From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Tue, 31 Oct 2006 12:45:54 +1100
Message-ID: <1162259155.26676.16.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061030231132.GA98768@muc.de>
	 <20061030234215.GA5881@sequoia.sous-sol.org>
	 <200610310046.01388.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965172AbWJaBqF@vger.kernel.org>
In-Reply-To: <200610310046.01388.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-10-31 at 00:46 +0100, Andi Kleen wrote:
> On Tuesday 31 October 2006 00:42, Chris Wright wrote:
> 
> > > I could do it myself, but then retransmits from Chris would be difficult
> > > if anything else would need to be changed.
> > > 
> > > Also fixing that !-Os compile error in the original patches would be good.
> > 
> > Hmm, builds fine here.  If you have a .config and/or error message I'll
> > fix it up.
> 
> I haven't tried it myself (my laptop was on battery all the time
> and I didn't want to drain it with a full rebuild ;-), there was just a report
> that it didn't work. Or maybe that was with an old patch. If it works it's fine.

The -Os thing was a red herring.  It was a brokenpatch in the original 4
which for which I immediately sent a fixup to akpm.  Here it is again
below:

==
Move write_dt_entry back: moving it up breaks compile.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -78,6 +78,17 @@ static inline void load_TLS(struct threa
 #undef C
 }
 
+#define write_ldt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_gdt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+#define write_idt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
+
+static inline void write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
+{
+	u32 *lp = (u32 *)((char *)dt + entry*8);
+	lp[0] = entry_low;
+	lp[1] = entry_high;
+}
+
 static inline void set_ldt(void *addr, unsigned int entries)
 {
 	if (likely(entries == 0))
@@ -92,17 +103,6 @@ static inline void set_ldt(void *addr, u
 		write_gdt_entry(get_cpu_gdt_table(cpu), GDT_ENTRY_LDT, low, high);
 		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
 	}
-}
-
-#define write_ldt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-#define write_gdt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-#define write_idt_entry(dt, entry, low, high) write_dt_entry(dt,entry,low,high)
-
-static inline void write_dt_entry(void *dt, int entry, u32 entry_low, u32 entry_high)
-{
-	u32 *lp = (u32 *)((char *)dt + entry*8);
-	lp[0] = entry_low;
-	lp[1] = entry_high;
 }
 
 static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
